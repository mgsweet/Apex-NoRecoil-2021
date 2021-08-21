from os import system

banners = {
    "header-start": """
 █████╗ ██████╗ ███████╗██╗  ██╗     ███╗   ██╗ ██████╗ ██████╗ ███████╗ ██████╗ ██████╗ ██╗██╗     
██╔══██╗██╔══██╗██╔════╝╚██╗██╔╝     ████╗  ██║██╔═══██╗██╔══██╗██╔════╝██╔════╝██╔═══██╗██║██║     
███████║██████╔╝█████╗   ╚███╔╝█████╗██╔██╗ ██║██║   ██║██████╔╝█████╗  ██║     ██║   ██║██║██║     
██╔══██║██╔═══╝ ██╔══╝   ██╔██╗╚════╝██║╚██╗██║██║   ██║██╔══██╗██╔══╝  ██║     ██║   ██║██║██║     
██║  ██║██║     ███████╗██╔╝ ██╗     ██║ ╚████║╚██████╔╝██║  ██║███████╗╚██████╗╚██████╔╝██║███████╗
╚═╝  ╚═╝╚═╝     ╚══════╝╚═╝  ╚═╝     ╚═╝  ╚═══╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝ ╚═════╝ ╚═════╝ ╚═╝╚══════╝
by: krampus-nuggets | credit: mgsweet
    """,
    "header-stop": """
██████╗ ██╗   ██╗███████╗       ██╗ 
██╔══██╗╚██╗ ██╔╝██╔════╝    ██╗╚██╗
██████╔╝ ╚████╔╝ █████╗      ╚═╝ ██║
██╔══██╗  ╚██╔╝  ██╔══╝      ██╗ ██║
██████╔╝   ██║   ███████╗    ╚═╝██╔╝
╚═════╝    ╚═╝   ╚══════╝       ╚═╝
    """,
    "user-options": """
All available options listed below:

1. Toggle recoil control | Press DEL
2. Load primary pattern | Press 1
3. Load secondary pattern | Press 2
4. Kill program | Press /
    """,
    "action-close-program": "ACTION: Program Closed",
    "helpers-scan-one": "Please input the values for the first scan box below: [Ex. - left,top,width,height]",
    "helpers-scan-two": "Please input the values for the second scan box below: [Ex. - left,top,width,height]",
    "helpers-modifier": "Please input the recoil-pattern sensitivity modifier value below: [Ex. 2.5]",
    "helpers-intro": """
STATUS: Config file not found!
A config file will now be generated, please follow the steps outlined below.
    """
}

def print_banner(ban_type, *banner):
    if ban_type == "single":
        system("cls")
        print(banners[banner[0]])
    elif ban_type == "double":
        system("cls")
        print(banners[banner[0]])
        print(banners[banner[1]])
    elif ban_type == "no-clear":
        print(banners[banner[0]])