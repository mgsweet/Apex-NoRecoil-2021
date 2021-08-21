from modules.banners import print_banner
import yaml
import os

yaml_config = f"{os.path.dirname(os.path.abspath(__file__))}\\config.yaml"

def config_generator():
    print_banner("double", "header-start", "helpers-intro")

    print_banner("no-clear", "helpers-scan-one")
    weapon_scan_box_one = input().split(",")

    weapon_one_scan_coordinates = {
        "left": int(weapon_scan_box_one[0]),
        "top": int(weapon_scan_box_one[1]),
        "width": int(weapon_scan_box_one[2]),
        "height": int(weapon_scan_box_one[3])
    }

    print_banner("no-clear", "helpers-scan-two")
    weapon_scan_box_two = input().split(",")

    weapon_two_scan_coordinates = {
        "left": int(weapon_scan_box_two[0]),
        "top": int(weapon_scan_box_two[1]),
        "width": int(weapon_scan_box_two[2]),
        "height": int(weapon_scan_box_two[3])
    }

    print_banner("no-clear", "helpers-modifier")
    recoil_pattern_modifer = float(input())

    data = dict(
        scan_coord_one = weapon_one_scan_coordinates,
        scan_coord_two = weapon_two_scan_coordinates,
        modifier_value = recoil_pattern_modifer
    )

    with open(yaml_config, "w") as outfile:
        yaml.dump(data, outfile, default_flow_style=False)
        outfile.close()

def read_config():
    config_file = yaml_config
    stream = open(config_file, "r")
    return yaml.load(stream, Loader=yaml.SafeLoader)