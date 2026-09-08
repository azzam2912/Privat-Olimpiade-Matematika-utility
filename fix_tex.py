import re

file_path = "/Users/xeratha-hagavi/LaTeX Project/Privat-Olimpiade-Matematika-utility/1 Aljabar/Fungsi Satria Pelatnas IMO 2019.tex"
with open(file_path, "r", encoding="utf-8") as f:
    content = f.read()

# Remove ```
content = re.sub(r'```\n?', '', content)

# Replace ' \n' with ' \\\n' inside align* blocks
def fix_align(match):
    block = match.group(0)
    # find lines ending with a single backslash
    block = re.sub(r' \\\n', r' \\\\\n', block)
    block = re.sub(r'(?<!\\)\\(\r?\n)', r'\\\\\1', block)
    return block

content = re.sub(r'\\begin\{align\*\}.*?\\end\{align\*\}', fix_align, content, flags=re.DOTALL)

# Add line spacing
if '\\linespread' not in content:
    content = content.replace('\\begin{document}', '\\linespread{1.3}\n\\begin{document}')

with open(file_path, "w", encoding="utf-8") as f:
    f.write(content)

print("Done")
