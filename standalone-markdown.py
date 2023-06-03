#!/usr/bin/env python3

import re
import os
import sys
from base64 import b64encode

def main():
    if len(sys.argv) != 2:
        print(f'[-] Usage: ./{os.path.basename(__file__)} <markdown-file>')
        sys.exit(1)
    fname: str = sys.argv[1]
    bpath: str = os.path.dirname(fname)
    if not os.path.isfile(fname):
        print(f'[-] File "{fname}" doesn\'t exist ... ')
        sys.exit(1)
    with open(fname, 'r') as f:
        with open(f'{".".join(fname.split(".")[:-1])}.standalone.md', 'w') as o:
            c: str = f.read()
            for m in re.findall(r'!\[[^\]]*\]\([^\)]*\)', c):
                iname: str = m.split('(')[1].split(')')[0]
                alt: str = m.split('[')[1].split(']')[0]
                with open(os.path.join(bpath, iname), 'rb') as img:
                    base: str = b64encode(img.read()).decode()
                c = c.replace(m, f'<div align="center"><img src="data:image/{iname.split(".")[-1]};base64,{base}" alt="{alt}" /></div>')
            o.write(c)

if __name__ == '__main__':
    main()
