#!/bin/bash
# runhltconfig.sh #
MENU="/dev/CMSSW_10_3_0/HIon/V47"
CONFIG=expHLT_130X_ImportV47L1_cfg
FILE=file:/eos/cms/store/hidata/HIRun2018A/HIMinimumBias2/RAW/v1/000/326/521/00000/6B525676-E485-B644-A8C5-955BE817C6F5.root # MB data 2018
emuL1org=/afs/cern.ch/user/w/wangj/public/menu/L1Menu_CollisionsHeavyIons2018_v4_cent.xml
emulL1="--l1-emulator FullMC --l1Xml=L1Menu_CollisionsHeavyIons2018_v4_cent.xml"

mkdir -p ../L1Trigger/L1TGlobal/data/Luminosity/startup
cp $emuL1org ../L1Trigger/L1TGlobal/data/Luminosity/startup/

hltGetConfiguration $MENU \
    --globaltag 103X_dataRun2_HLT_v1 \
    --input $FILE \
    --process MYHLT --full --online --data --unprescale --max-events 10 > ${CONFIG}.py

sed -i 's/numberOfThreads = cms.untracked\.uint32( 4 )/numberOfThreads = cms.untracked.uint32( 1 )/g' ${CONFIG}.py
sed -i 's/process\.DQMStore\.enableMultiThread = True/process.DQMStore.enableMultiThread = False/g' ${CONFIG}.py


echo '
# hltbitanalysis
process.load("HLTrigger.HLTanalyzers.HLTBitAnalyser_cfi")
process.hltbitanalysis.HLTProcessName = cms.string("MYHLT")
process.hltbitanalysis.hltresults = cms.InputTag( "TriggerResults","","MYHLT" )
process.hltbitanalysis.l1results = cms.InputTag("hltGtStage2Digis","","MYHLT")
process.hltbitanalysis.UseTFileService = cms.untracked.bool(True)
process.hltbitanalysis.RunParameters = cms.PSet(
    isData = cms.untracked.bool(True))
process.hltBitAnalysis = cms.EndPath(process.hltbitanalysis)
process.TFileService = cms.Service("TFileService",
                                   fileName=cms.string("openHLT.root"))' >> ${CONFIG}.py

edmConfigDump ${CONFIG}.py >& ${CONFIG}_DUMP.py
sed -i 's/"rawDataCollector"/"rawDataRepacker"/g' ${CONFIG}_DUMP.py

