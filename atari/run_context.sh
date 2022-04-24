#!/usr/bin/env bash

NUM_LAUNCHED=0
NUM_GPUS=8

# Decision Transformer (DT) with context_length = 30 or 50
for seed in 0 1 2
do
    CUDA_VISIBLE_DEVICES=$(($NUM_LAUNCHED % $NUM_GPUS)) python run_dt_atari.py --seed $seed --context_length 30 --epochs 5 --model_type 'reward_conditioned' --num_steps 500000 --num_buffers 50 --game 'Breakout' --batch_size 128 &
    NUM_LAUNCHED=$((NUM_LAUNCHED + 1))
    sleep 3
done

for seed in 0 1 2
do
    CUDA_VISIBLE_DEVICES=$(($NUM_LAUNCHED % $NUM_GPUS)) python run_dt_atari.py --seed $seed --context_length 30 --epochs 5 --model_type 'reward_conditioned' --num_steps 500000 --num_buffers 50 --game 'Qbert' --batch_size 128 &
    NUM_LAUNCHED=$((NUM_LAUNCHED + 1))
    sleep 3
done

for seed in 0 1 2
do
    CUDA_VISIBLE_DEVICES=$(($NUM_LAUNCHED % $NUM_GPUS)) python run_dt_atari.py --seed $seed --context_length 50 --epochs 5 --model_type 'reward_conditioned' --num_steps 500000 --num_buffers 50 --game 'Pong' --batch_size 512 &
    NUM_LAUNCHED=$((NUM_LAUNCHED + 1))
    sleep 3
done

for seed in 0 1 2
do
    CUDA_VISIBLE_DEVICES=$(($NUM_LAUNCHED % $NUM_GPUS)) python run_dt_atari.py --seed $seed --context_length 30 --epochs 5 --model_type 'reward_conditioned' --num_steps 500000 --num_buffers 50 --game 'Seaquest' --batch_size 128 &
    NUM_LAUNCHED=$((NUM_LAUNCHED + 1))
    sleep 3
done

# Decision Transformer (DT) with context_length = 1
for seed in 0 1 2
do
    CUDA_VISIBLE_DEVICES=$(($NUM_LAUNCHED % $NUM_GPUS)) python run_dt_atari.py --seed $seed --context_length 1 --epochs 5 --model_type 'reward_conditioned' --num_steps 500000 --num_buffers 50 --game 'Breakout' --batch_size 128 &
    NUM_LAUNCHED=$((NUM_LAUNCHED + 1))
    sleep 3
done

for seed in 0 1 2
do
    CUDA_VISIBLE_DEVICES=$(($NUM_LAUNCHED % $NUM_GPUS)) python run_dt_atari.py --seed $seed --context_length 1 --epochs 5 --model_type 'reward_conditioned' --num_steps 500000 --num_buffers 50 --game 'Qbert' --batch_size 128 &
    NUM_LAUNCHED=$((NUM_LAUNCHED + 1))
    sleep 3
done

for seed in 0 1 2
do
    CUDA_VISIBLE_DEVICES=$(($NUM_LAUNCHED % $NUM_GPUS)) python run_dt_atari.py --seed $seed --context_length 1 --epochs 5 --model_type 'reward_conditioned' --num_steps 500000 --num_buffers 50 --game 'Pong' --batch_size 512 &
    NUM_LAUNCHED=$((NUM_LAUNCHED + 1))
    sleep 3
done

for seed in 0 1 2
do
    CUDA_VISIBLE_DEVICES=$(($NUM_LAUNCHED % $NUM_GPUS)) python run_dt_atari.py --seed $seed --context_length 1 --epochs 5 --model_type 'reward_conditioned' --num_steps 500000 --num_buffers 50 --game 'Seaquest' --batch_size 128 &
    NUM_LAUNCHED=$((NUM_LAUNCHED + 1))
    sleep 3
done

wait
