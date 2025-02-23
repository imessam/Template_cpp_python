from modules.i_interface_name import IInterface
from modules.class_implemented_derived import ClassImplementedDerived

import sys
import yaml

def main():

    config_file = sys.argv[1]

    with open(config_file, 'r') as file:
        config = yaml.safe_load(file)

    class_implemented_derived = ClassImplementedDerived()

    if class_implemented_derived.start() != IInterface.STATUS.OK_STARTED:
        return 1
    
    if class_implemented_derived.stop() != IInterface.STATUS.OK_STOPPED:
        return 1
    
    return 0

if __name__ == "__main__":
    sys.exit(main())