#!/bin/bash
wget -q -O - $ORIGIN_FILE | pandoc --columns=200 -t adoc | csplit - -q --prefix=appdx-evm-opcodes-gas- -b "%02d.adoc" /$OPCODES_BEGIN_MARKER/ /$OPCODES_END_MARKER/

