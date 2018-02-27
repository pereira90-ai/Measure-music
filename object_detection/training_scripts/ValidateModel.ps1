$pathToGitRoot = "C:/Users/Alex/Repositories/Mensural-Detector"
$pathToSourceRoot = "$($pathToGitRoot)/object_detection"
$pathToTranscript = "$($pathToSourceRoot)/transcripts"
cd $pathToSourceRoot

# Make sure that python finds all modules inside this directory
echo "Appending required paths to temporary PYTHONPATH"
$env:PYTHONPATH = "$($pathToGitRoot);$($pathToSourceRoot);$($pathToGitRoot)/slim"

################################################################
# Available configurations - uncomment the one to actually run #
################################################################
# $configuration = "faster_rcnn_inception_resnet_v2_atrous"
# $configuration = "faster_rcnn_inception_resnet_v2_atrous_600_proposals"
# $configuration = "faster_rcnn_inception_resnet_v2_atrous_600_proposals_pretrained"
# $configuration = "faster_rcnn_inception_resnet_v2_atrous_1200_proposals"
# $configuration = "faster_rcnn_inception_resnet_v2_atrous_1200_proposals_max_suppr_09"
# $configuration = "faster_rcnn_inception_resnet_v2_atrous_1200_proposals_max_suppr_03"
# $configuration = "faster_rcnn_inception_resnet_v2_atrous_1200_proposals_only_rpn"
$configuration = "ssd_inception_v2_focal_loss"

Start-Transcript -path "$($pathToTranscript)/ValidateModel-$($configuration).txt" -append
echo "Validate with $($configuration) configuration"
python eval.py --logtostderr --pipeline_config_path="$($pathToSourceRoot)/configurations/$($configuration).config" --checkpoint_dir="$($pathToSourceRoot)/data/checkpoints-$($configuration)-train" --eval_dir="$($pathToSourceRoot)/data/checkpoints-$($configuration)-validate"
Stop-Transcript

