#! /bin/bash
# set -ex

export ONEFLOW_GPT_NUM_GPUS_PER_NODE=8
export ONEFLOW_GPT_NUM_NODES=4
# export ONEFLOW_GPT_NODE_IPS="192.168.1.16,192.168.1.15,192.168.1.14,192.168.1.13"

# export ONEFLOW_GPT_DATASET=/data/gpt/gpt_sample_dataset_text_document
export ONEFLOW_GPT_SEQ_LENGTH=2048

export ONEFLOW_GPT_HIDDEN_SIZE=2304
export ONEFLOW_GPT_NUM_ATTENTION_HEADS=24
export ONEFLOW_GPT_NUM_LAYERS=24

export ONEFLOW_GPT_TENSOR_MODEL_PARALLEL_SIZE=4
export ONEFLOW_GPT_PIPELINE_MODEL_PARALLEL_SIZE=4

export ONEFLOW_GPT_MICRO_BATCH_SIZE=8
export ONEFLOW_GPT_GLOBAL_BATCH_SIZE=512

export ONEFLOW_GTP_PRETRAIN_WITH_CONTAINER=ON
export ONEFLOW_GPT_SRC_DIR=$(realpath $(dirname $(dirname $0)))
export ONEFLOW_DEV_IMAGE=oneflow-manylinux2014-cuda11.2:0.1
export ONEFLOW_GPT_PYTHON_VERSION=3.7
export ONEFLOW_WHEEL=$PWD/packages/oneflow-0.3.5+cu102.git.8b222eed2-cp37-cp37m-manylinux2014_x86_64.whl
# Set this env for mounting data dir for container
# export ONEFLOW_GPT_DATA_DIR=$(dirname $ONEFLOW_GPT_DATASET)

source $(dirname $0)/pretrain.sh
