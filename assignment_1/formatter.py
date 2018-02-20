import sys

if __name__ == '__main__':
    if len(sys.argv) == 1:
        sys.exit('Too few arguments')

    filename = sys.argv[1]
    f = open(filename, 'r')
    content = f.read()
    f.close()
    new_content = content.replace('   ', ',').strip()
    new_filename = "%s.csv" % filename
    fi = open(new_filename, 'w')
    fi.write(new_content[1:])
    fi.close()
    
        
