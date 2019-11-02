#!/bin/sh
BOARD_TYPE=`get_board_info_utility BOARD_TYPE 2>/dev/null`

# Load the linux I2c and shim modules
echo "Set smp_affinity on Board $BOARD_TYPE"
case $BOARD_TYPE in
    "CE2600_BOARD_HP")
	echo "Set 2 to  irq 16"
	echo "Set 2 to  irq 17"
        echo "2" > /proc/irq/16/smp_affinity
        echo "2" > /proc/irq/17/smp_affinity
        ;;
    "CE2600_BOARD_HPMG")
	echo "Set 2 to  irq 16"
	echo "Set 2 to  irq 17"
        echo "2" > /proc/irq/16/smp_affinity
        echo "2" > /proc/irq/17/smp_affinity
        ;;
    "CE2600_BOARD_GS")
	echo "Set 2 to  irq 16"
	echo "Set 2 to  irq 17"
        echo "2" > /proc/irq/16/smp_affinity
        echo "2" > /proc/irq/17/smp_affinity
        ;;
esac

