import os
import sys
from modules import *
import re

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
        [1] Exit
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
        [1] Exit
"""

goodbye = """
  _______   ______     ______    _______  .______   ____    ____  _______
 /  _____| /  __  \   /  __  \  |       \ |   _  \  \   \  /   / |   ____|
|  |  __  |  |  |  | |  |  |  | |  .--.  ||  |_)  |  \   \/   /  |  |__
|  | |_ | |  |  |  | |  |  |  | |  |  |  ||   _  <    \_    _/   |   __|
|  |__| | |  `--'  | |  `--'  | |  '--'  ||  |_)  |     |  |     |  |____
 \______|  \______/   \______/  |_______/ |______/      |__|     |_______|

"""


def remote():
    # Check if .cfg file exists
    try:
        conf = cfg_func(sys.argv[1])
    except:
        print(".cfg file doesn't exist")
        return

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
                while prompt != 1:
                    if prompt == 0:
                        remote()
                        print(alt_menu)
                        prompt = int(input(f"Your choice: "))


                    # handling wrong prompts
                    else:
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
