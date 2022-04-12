#!/usr/bin/env bash

mkdir dqn_replay
gsutil -m cp -R gs://atari-replay-datasets/dqn/Breakout dqn_replay
gsutil -m cp -R gs://atari-replay-datasets/dqn/Qbert dqn_replay
gsutil -m cp -R gs://atari-replay-datasets/dqn/Pong dqn_replay
gsutil -m cp -R gs://atari-replay-datasets/dqn/Seaquest dqn_replay