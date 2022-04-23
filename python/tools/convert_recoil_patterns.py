from glob import glob
from os.path import dirname

working_dir = dirname(__file__)
project_dir = working_dir.replace('\\python\\tools', '')
recoil_pattern_dir = project_dir + '\\AHK\\src\\pattern\\'

exclude_list = ['DevotionTurbo', 'HavocTurbo', 'RampageAmp']

def get_patterns(pattern_dir):
    patterns = []

    for file in glob(recoil_pattern_dir + '*.txt'):
        if any(word in file for word in exclude_list):
            pass
        else:
            patterns.append(file)

    return patterns

def get_weapon_names(file_list):
    filenames = []

    for file in file_list:
        filename = file.split('\\')
        filename = filename[-1].replace('.txt', '')
        filenames.append(filename)

    return filenames

def get_recoil_values(pattern_file):
    pattern_list = []

    with open(pattern_file, 'r') as file:
        for line in file:
            formatted_line = line.strip()
            formatted_line = formatted_line.split(',')
            converted_delay = round(float(formatted_line[2]) / 1000, 4)
            pattern_list.append([int(formatted_line[0]), int(formatted_line[1]), converted_delay])

    return pattern_list

def main():
    patterns = sorted(get_patterns(recoil_pattern_dir))
    weapons = sorted(get_weapon_names(patterns))

    with open(f'{working_dir}\\output.txt', 'w') as output:
        for pattern_index, pattern in enumerate(patterns):
            try:
                weapon_data = f'WEAPON: {weapons[pattern_index]} | PATTERN: {get_recoil_values(pattern)} \n\n'
                output.write(weapon_data)
            except IndexError:
                continue

        output.close()

main()
