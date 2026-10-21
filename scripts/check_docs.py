#!/usr/bin/env python3
"""Compile the executable examples in the README and extracted guides."""
from pathlib import Path
import re
import subprocess
import tempfile

ROOT = Path(__file__).resolve().parents[1]
FENCE = re.compile(r'^```lean\s*\n(.*?)^```\s*$', re.M | re.S)

def main():
    blocks = []
    imports = {'import QProduct.LeanCert'}
    for path in [ROOT / 'README.md', *sorted((ROOT / 'docs').rglob('*.md'))]:
        for i, match in enumerate(FENCE.finditer(path.read_text()), 1):
            body = []
            for line in match[1].splitlines():
                if line.startswith('import '):
                    imports.add(line)
                else:
                    body.append(line)
            blocks.append((f'{path.relative_to(ROOT)} block {i}', '\n'.join(body)))
    # Doc examples may import dependency modules outside this package's build closure.
    modules = sorted(line.split()[1] for line in imports)
    subprocess.run(['lake', '--no-cache', 'build', *modules], cwd=ROOT, check=True)
    source = '\n'.join(sorted(imports)) + '\nopen QProduct QProduct.ConstantFactory\n'
    for i, (label, body) in enumerate(blocks):
        source += f'\n-- {label}\nnamespace DocBlock{i}\n{body}\nend DocBlock{i}\n'
    with tempfile.TemporaryDirectory(prefix='qproduct-docs-') as directory:
        path = Path(directory) / 'Docs.lean'
        path.write_text(source)
        subprocess.run(['lake', '--no-cache', 'env', 'lean', str(path)], cwd=ROOT, check=True)
    print(f'Checked {len(blocks)} documentation examples.')

if __name__ == '__main__':
    main()
