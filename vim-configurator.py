#!/usr/bin/env python

#Best solution will be 
#to use little scripts for 
#the os commands like mv git cd
#subprocess.call(['./test.sh'])
#make apt-get in pyhton

import apt
import sys
import getopt
import subprocess

def main(argv):
    os = ''
    clang = ''
    desktop = ''
    latex = ''
    utility = ''
    name = ''
    
    try:
        opts, args = getopt.getopt(argv,"hn:o:cd:lu",["os=","desktop=","latex=","utility="])
    except getopt.GetoptError:
        print 'test.py -i <inputfile>'
        sys.exit(2)
    for opt, arg in opts:
        if opt == '-h':
            print 'help'
            sys.exit()
        elif opt == '-n':
            name = arg
            print name
        elif opt in ("-o", "--os"):
            os = arg
            if os in ("kubuntu"):
                print os
            else:
                print "{os} not supported"
        elif opt in ("-c", "--clang"):
            clang = True
            print clang
            install("clang-3.7")
            install("clang-format-3.7")
            subprocess.call(['ln','-s','/usr/bin/clang-format-3.7','/usr/bin/clang-format'])
            install("cmake")
        elif opt in ("-d","--desktop"):
            desktop = arg
            if desktop in ("kde"):
                print desktop
                install("vim-gtk")
            elif desktop in ("gnome"):
                install("vim-gnome")
            else:
                print "{desktop} not supported"
        elif opt in ("-l","--latex"):
            latex = True
        elif opt in ("-u","utility"):
            utility = True
            #install("exuberant-ctags") 
            #install("curl")
            #install("vim-pathogen")
            #subprocess.call(['mkdir', '.vim/bundle'],cwd='/home/osboxes/')
            subprocess.call(['ls','-l'],cwd='/home/osboxes/.vim')
            subprocess.call(['git','clone','link'],cwd='/home/osboxes/.vim')
            
            
def install(pkg_name):

    cache = apt.cache.Cache()
    cache.update()

    pkg = cache[pkg_name]

    if pkg.is_installed:
        print "{pkg_name} already installed".format(pkg_name=pkg_name)
    else:
        pkg.mark_install()
    
        try:
            cache.commit()
        except Exception, arg:
            print >> sys.stderr, "Sorry, package installation failed [{err}]"
        



if __name__ == "__main__":
    main(sys.argv[1:])
