require 'mkmf'

RbConfig::MAKEFILE_CONFIG['CC'] = ENV['CC'] if ENV['CC']

if have_header('capstone/capstone.h')
  $LDFLAGS << ' -lcapstone'
end

$warnflags.gsub! '-Wdeclaration-after-statement', ''

$CFLAGS << ' -std=c11 -pedantic -fstrict-aliasing'
$warnflags << ' -Wextra -Wall -Wno-unused-label -Wuninitialized'\
              ' -Wswitch-default  -Wstrict-aliasing=3 -Wunreachable-code'\
              ' -Wundef -Wpointer-arith -Wwrite-strings -Wconversion -Winit-self -Wno-unused-parameter'

$LDFLAGS << ''

if RbConfig::MAKEFILE_CONFIG['CC'] =~ /clang/
  $warnflags << ' -Wno-unknown-warning-option -Wno-parentheses-equality -Wno-error=ignored-attributes'\
                ' -Wno-missing-field-initializers -Wno-missing-braces'
end

if enable_config('debug')
  $warnflags << ' -Werror -Wno-error=unused-function -Wno-error=pedantic'\
             ' -Wno-error=implicit-function-declaration'
  $defs.push('-DEVOASM_MIN_LOG_LEVEL=EVOASM_LOG_LEVEL_DEBUG')
  $CFLAGS.gsub!(/-O\d/, '')
  $CFLAGS << ' -O0 -g3 -fno-omit-frame-pointer'
end

create_makefile('evoasm_ext')