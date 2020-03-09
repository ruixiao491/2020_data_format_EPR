# 2020_data_format_EPR
The links that I use are: (1) https://twiki.cern.ch/twiki/bin/view/CMSPublic/SWGuideGlobalHLT#CMSSW_10_3_X_2018_HIon_data_taki  (2)https://twiki.cern.ch/twiki/bin/view/CMSPublic/SWGuideHltGetConfiguration

set up:

cmsrel CMSSW_10_3_3_patch1
cd CMSSW_10_3_3_patch1/src
cmsenv

git cms-addpkg HLTrigger/Configuration

scram build -j 4
mkdir hlt
cd hlt
Get HLT configuration: create a script with content as
./runhltconfig.sh

In runhltconfig.sh: 
menu: MENU="/dev/CMSSW_10_3_0/HIon/V47"
--globaltag 101X_dataRun2_HLT_v7


Run hltconfig:
cmsRun expHLT_130X_ImportV47L1_cfg_DUMP.py
