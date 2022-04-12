#!/usr/bin/env bash

# Decision Transformer (DT) with context_length = 30 or 50
for seed in 0 1 2
do
    CUDA_VISIBLE_DEVICES=0 python run_dt_atari.py --seed $seed --context_length 30 --epochs 5 --model_type 'reward_conditioned' --num_steps 500000 --num_buffers 50 --game 'Breakout' --batch_size 128 &
    sleep 3
done

for seed in 0 1 2
do
    CUDA_VISIBLE_DEVICES=1 python run_dt_atari.py --seed $seed --context_length 30 --epochs 5 --model_type 'reward_conditioned' --num_steps 500000 --num_buffers 50 --game 'Qbert' --batch_size 128 &
    sleep 3
done

for seed in 0 1 2
do
    CUDA_VISIBLE_DEVICES=2 python run_dt_atari.py --seed $seed --context_length 50 --epochs 5 --model_type 'reward_conditioned' --num_steps 500000 --num_buffers 50 --game 'Pong' --batch_size 512 &
    sleep 3
done

for seed in 0 1 2
do
    CUDA_VISIBLE_DEVICES=3 python run_dt_atari.py --seed $seed --context_length 30 --epochs 5 --model_type 'reward_conditioned' --num_steps 500000 --num_buffers 50 --game 'Seaquest' --batch_size 128 &
    sleep 3
done

# Decision Transformer (DT) with context_length = 1
for seed in 0 1 2
do
    CUDA_VISIBLE_DEVICES=4 python run_dt_atari.py --seed $seed --context_length 1 --epochs 5 --model_type 'reward_conditioned' --num_steps 500000 --num_buffers 50 --game 'Breakout' --batch_size 128 &
    sleep 3
done

for seed in 0 1 2
do
    CUDA_VISIBLE_DEVICES=5 python run_dt_atari.py --seed $seed --context_length 1 --epochs 5 --model_type 'reward_conditioned' --num_steps 500000 --num_buffers 50 --game 'Qbert' --batch_size 128 &
    sleep 3
done

for seed in 0 1 2
do
    CUDA_VISIBLE_DEVICES=6 python run_dt_atari.py --seed $seed --context_length 1 --epochs 5 --model_type 'reward_conditioned' --num_steps 500000 --num_buffers 50 --game 'Pong' --batch_size 512 &
    sleep 3
done

for seed in 0 1 2
do
    CUDA_VISIBLE_DEVICES=7 python run_dt_atari.py --seed $seed --context_length 1 --epochs 5 --model_type 'reward_conditioned' --num_steps 500000 --num_buffers 50 --game 'Seaquest' --batch_size 128 &
    sleep 3
done