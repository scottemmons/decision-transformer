envs = ["antmaze"]
datasets = ["umaze", "umaze-diverse", "medium-play", "medium-diverse", "large-play", "large-diverse"]
num_seeds = 5
filename = "taskfile.sh"


def write_to_file(lines, outfile=filename, mode="w"):
    with open(outfile, mode) as f:
        f.writelines(line + "\n" for line in lines)


def main():
    lines = []
    command_head = "singularity exec --nv -B /usr/lib64 -B /var/lib/dcv-gl --overlay /global/scratch/users/emmons/singularity/overlay-50G-10M.ext3:ro /global/scratch/users/emmons/singularity/cuda10.2-cudnn7-devel-ubuntu18.04.sif /bin/bash -c \"source /ext3/env.sh; conda activate decision-transformer-gym; cd /global/scratch/users/emmons/decision-transformer/gym; python experiment.py -w True --model_type dt"
    for _ in range(num_seeds):
        for dataset in datasets:
            for env in envs:
                command = command_head + " --env " + env + " --dataset " + dataset + '"'
                lines.append(command)

    write_to_file(lines)
    write_to_file(["sleep 600"], mode="a")


if __name__ == "__main__":
    main()
