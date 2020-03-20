# 2020_data_format_EPR
The links that I use are: (1) https://twiki.cern.ch/twiki/bin/view/CMSPublic/SWGuideGlobalHLT#CMSSW_10_3_X_2018_HIon_data_taki 

(2)https://twiki.cern.ch/twiki/bin/view/CMSPublic/SWGuideHltGetConfiguration

(3)refence: https://twiki.cern.ch/twiki/bin/viewauth/CMS/HiHighPtTrigger2018#Instructions_as_of_2018_10_14_in

This is what we used for the 2018 run preparation:

set up:

cmsrel CMSSW_10_3_0_pre6

cd CMSSW_10_3_0_pre6/src

cmsenv

git cms-init

git remote add cms-l1t-offline git@github.com:cms-l1t-offline/cmssw.git

git fetch cms-l1t-offline l1t-integration-CMSSW_10_2_1

git cms-addpkg L1Trigger/L1TCommon

git cms-addpkg L1Trigger/L1TMuon

git clone https://github.com/cms-l1t-offline/L1Trigger-L1TMuon.git L1Trigger/L1TMuon/data

git cms-addpkg L1Trigger/L1TCalorimeter

git cms-addpkg L1Trigger/L1TGlobal # For xml

mkdir -p L1Trigger/L1TGlobal/data/Luminosity/startup/

cp /afs/cern.ch/user/i/icali/public/L1Menu_CollisionsHeavyIons2018_v4.xml L1Trigger/L1TGlobal/data/Luminosity/startup/

git cms-addpkg HLTrigger/Configuration

git clone https://github.com/cms-l1t-offline/L1Trigger-L1TCalorimeter.git L1Trigger/L1TCalorimeter/data

git cms-merge-topic -u 24857

git cms-merge-topic -u boundino:fixcentsat # needed for centrality

git cms-merge-topic -u cfmcginn:HIL1Stage2_L1Intv101p0_CMSSW1021_1030pre5Mergeable #Still needed for jets

#Check dependencies and build

git cms-checkdeps -A -a

scram b -j4

mkdir hlt

cd hlt

Get HLT configuration: create a script with content as

./runhltconfig.sh

In runhltconfig.sh: 

menu: MENU="/dev/CMSSW_10_3_0/HIon/V47"
--globaltag 101X_dataRun2_HLT_v7


Run hltconfig:

cmsRun expHLT_130X_ImportV47L1_cfg_DUMP.py


after produced expHLT_130X_ImportV47L1_cfg_DUMP.py, we need to change process.rawDataRepacker to process.rawDataRepacker2.



After change process.rawDataRepacker to process.rawDataRepacker2 and remove some not used triggers, the configuration file is now named "expHLT_130X_ImportV47L1_cfg_DUMP_rawdata_repacker2.py.
In this configuration file, we also try to keep pixel information collection.

