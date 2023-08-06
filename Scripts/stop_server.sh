#!/bin/bash

#!/bin/bash
isExistApp = `pgrep php`
if [[ -n  $isExistApp ]]; then
    service php stop        
fi
