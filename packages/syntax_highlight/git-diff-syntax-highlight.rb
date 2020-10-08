#!/usr/bin/env ruby
require 'coderay'
require 'term/ansicolor'
require 'optparse'

# --- Adjusting colors -------------------------------------------------------

RGB = Term::ANSIColor::RGBTriple
Attribute = Term::ANSIColor::Attribute
Color = Term::ANSIColor

GREEN = RGB.new(0, 256, 0)
RED   = RGB.new(256, 0, 0)
GRAY  = RGB.new(180, 180, 180)

ADJUSTMENTS = {}
GRADIENTS   = {}

def adjust(text, target, gradient = 8)
  open     = adjust_seq("\e[37m", target, gradient)
  adjusted = text.chomp.gsub(/\e\[[0-9;]+m/) { |seq| adjust_seq(seq, target, gradient) }

  "#{open}#{adjusted}"
end

def adjust_seq(seq, target, level)
  key = [seq, target]

  ADJUSTMENTS[key] ||=
    begin
      escapes = []

      seq[/\d+(;\d+)*/].split(';').map(&:to_i).each do |number|
        case number
        when 0      then escapes << ["\e[0m", gradient_to(255, target, level)]
        when 1      then escapes << "\e[1m"
        when 4      then escapes << "\e[4m"
        when 30..37 then escapes << gradient_to(number - 30, target, level)
        when 40..47 then escapes << gradient_to(number - 30, target, level, :background)
        else             escapes << seq
        end
      end

      escapes.join('')
    end
end


def gradient_to(num, target, level, background = false)
  key = [num, target, background]

  GRADIENTS[key] ||=
    begin
      triple = triple(num)
      target = triple.gradient_to(target)[level]
      html   = target.html
      method = background ? "on_#{html}" : html

      Attribute[method].apply
    end
end

def triple(num)
  Attribute[num].to_rgb_triple
end

# --- Parsing git diffs ------------------------------------------------------

FORMATS = {
  'Gemfile' => :ruby,
  'rb' => :ruby,
  'c' => :c,
  'h' => :c,
  'cpp' => :cpp,
  'cxx' => :cpp,
  'hpp' => :cpp,
  'clj' => :clojure,
  'css' => :css,
  'erb' => :erb,
  'go' => :go,
  'java' => :java,
  'js' => :javascript,
  'json' => :json,
  'php' => :php,
  'lua' => :lua,
  'py' => :python,
  'sass' => :sass,
  'scss' => :scss,
  'sql' => :sql,
  'xml' => :xml,
  'yml' => :yaml,
  'yaml' => :yaml,
}

CACHED_OBJECTS = {}

def show(sha, path)
  return [] if sha =~ /^0+$/

  cached = CACHED_OBJECTS.delete sha
  return cached if cached

  format = FORMATS[path[/(\w+)$/, 1]]
  code = `git show #{sha} 2> /dev/null`
  code = File.read(path) if code.empty?
  code = CodeRay.scan(code, format).terminal if format
  CACHED_OBJECTS[sha] = code.lines
end

def process(options)
  new       = nil
  old       = nil
  remaining = nil
  old_file  = nil
  new_file  = nil
  old_hash  = nil
  new_hash  = nil

  while gets
    stripped = $_.gsub(/(\e\[[0-9;]*m)*/, '')
    case stripped
    when /^index (\w+)..(\w+)/
      old_hash = $1
      new_hash = $2
      puts $_
    # @@ -1,4 +1,4 @@
    when /^@@ -(\d+)(?:,(\d+))? \+(\d+)(?:,(\d+))? @@/
      old_start, old_length = $1.to_i - 1, ($2 || 1).to_i
      new_start, new_length = $3.to_i - 1, ($4 || 1).to_i

      remaining = old_length + new_length
      puts $_
    when /^\+\+\+ (.*)$/
      new_file = $1.sub(/^[ab]\//, '')
      old = show old_hash, old_file
      new = show new_hash, new_file
      puts $_
    when /^--- (.*)$/
      old_file = $1.sub(/^[ab]\//, '')
      puts $_
    when /^ /
      if remaining.nil? || remaining <= 0
        puts $_
        next
      elsif options[:highlight]
        puts adjust(" #{new[new_start]}", GRAY, 10)
      else
        puts $_
      end

      remaining -= 2
      old_start += 1
      new_start += 1
    when /^\+/
      puts adjust("+#{new[new_start]}", GREEN)
      new_start += 1
      remaining -= 1
    when /^-/
      puts adjust("-#{old[old_start]}", RED)
      old_start += 1
      remaining -= 1
    else
      puts $_
    end
  end
end

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: #{File.basename(__FILE__)} [options]"

  opts.on("-h", "--[no-]highlight", "Highlight all the code") do |v|
    options[:highlight] = v
  end
end.parse!

begin
  process(options)
rescue Errno::EPIPE
  exit 0
end
