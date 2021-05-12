rm -rf core.*
rm -rf ./output/snapshots/*

if [ -n "$1" ]; then
    NUM_EPOCH=$1
else
    NUM_EPOCH=37
fi
echo NUM_EPOCH=$NUM_EPOCH

# training with imagenet
if [ -n "$2" ]; then
    DATA_ROOT=$2
else
    DATA_ROOT=/DATA/disk1/ImageNet/ofrecord
fi
echo DATA_ROOT=$DATA_ROOT

LOG_FOLDER=../logs
mkdir -p $LOG_FOLDER
LOGFILE=$LOG_FOLDER/resnet_training.log

export PYTHONUNBUFFERED=1
echo PYTHONUNBUFFERED=$PYTHONUNBUFFERED
export NCCL_LAUNCH_MODE=PARALLEL
echo NCCL_LAUNCH_MODE=$NCCL_LAUNCH_MODE

python3 of_cnn_train_val.py \
     --train_data_dir=$DATA_ROOT/train \
     --train_data_part_num=256 \
     --val_data_dir=$DATA_ROOT/validation \
     --val_data_part_num=256 \
     --num_nodes=1 \
     --gpu_num_per_node=1 \
     --optimizer="sgdwlars" \
     --momentum=0.9 \
     --label_smoothing=0.1 \
     --learning_rate=7.4 \
     --loss_print_every_n_iter=100 \
     --batch_size_per_device=96 \
     --val_batch_size_per_device=100 \
     --use_fp16 \
     --channel_last=True \
     --fuse_bn_relu=True \
     --fuse_bn_add_relu=True \
     --nccl_fusion_threshold_mb=16 \
     --nccl_fusion_max_ops=24 \
     --gpu_image_decoder=True \
     --num_epoch=$NUM_EPOCH \
     --model="resnet50" \
      --model_load_dir="/home/xuefei/snapshot"

echo "Writting log to ${LOGFILE}"
