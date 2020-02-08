rm -rf core.*
#gdb --args \
#DATA_ROOT=/mnt/13_nfs/ImageNet
DATA_ROOT=/dataset/imagenet-mxnet
#nvprof -of resnet.nvvp \
  python3 cnn_benchmark/of_cnn_train_val.py \
    --data_train=$DATA_ROOT/train.rec \
    --data_train_idx=$DATA_ROOT/train.idx \
    --data_val=$DATA_ROOT/val.rec \
    --data_val_idx=$DATA_ROOT/val.idx \
    --gpu_num_per_node=4 \
    --optimizer="momentum-cosine-decay" \
    --weight_l2=3.0517578125e-05 \
    --learning_rate=0.256 \
    --loss_print_every_n_iter=20 \
    --batch_size_per_device=64 \
    --val_batch_size_per_device=125 \
    --model="resnet50" 
    #--weight_l2=3.0517578125e-05 \
    #--num_examples=1024 \
    #--optimizer="momentum-decay" \
    #--data_dir="/mnt/13_nfs/xuan/ImageNet/ofrecord/train"
    #--data_dir="/mnt/dataset/xuan/ImageNet/ofrecord/train"
    #--warmup_iter_num=10000 \
