###############################################################
# Include PSI packaging commands
###############################################################
source ../../../../Libraries/TCL/PsiIpPackage/PsiIpPackage.tcl
set vivadoVersion latest

###############################################################
# General Information
###############################################################
set IP_NAME sync_edge_det
set IP_VERSION 1.0
set IP_REVISION "auto"
set IP_LIBRARY GPAC3
set IP_DESCIRPTION "Synchronization and edge detection"

psi::ip_package::$vivadoVersion\::init $IP_NAME $IP_VERSION $IP_REVISION $IP_LIBRARY
psi::ip_package::$vivadoVersion\::set_description $IP_DESCIRPTION
psi::ip_package::$vivadoVersion\::set_logo_relative "../doc/psi_logo_150.gif"

###############################################################
# Add Source Files
###############################################################

#Relative Source Files
psi::ip_package::$vivadoVersion\::add_sources_relative { \
	../hdl/sync_edge_det.vhd \
}
		

###############################################################
# GUI Parameters
###############################################################

#Remove reset interface (Vivado messes up polarity...)
#psi::ip_package::$vivadoVersion\::remove_autodetected_interface Rst

###############################################################
# Package Core
###############################################################
set TargetDir ".."
#											Edit  Synth	
psi::ip_package::latest::package $TargetDir false true




