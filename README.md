# Dumpling: Fine-grained Differential JavaScript Engine Fuzzing


This document will walk you trough replicating the results from our paper: Dumpling: Fine-grained Differential JavaScript Engine Fuzzing published in NDSS'25.

The project is composed of a customized version of V8 and Fuzzilli based on the following base commits:
* V8 base commit: 6e70dc9e73af2a930074f4f000864fbc65515b74
* Fuzzilli base commit: 5696921ce2b021f5dacd56ba29f2a022c85b5891

For your convenience, we provide a docker-compose setup that takes care of fetching the relevant repos, installing dependencies, and building the components.
As such, you only need to install docker with docker-compose.
Our modification are organized as patches that will be automatically applied during the docker building.

The procedure for the initial build starts from [here](#getting-code-and-initial-requirements) while the commands to replicate our results are [here](#evaluation).


### Citation

```
@inproceedings{dumpling,
  author = {Wachter, Liam and Gremminger, Julian and Wressnegger, Christian and Payer, Mathias and Toffalini, Flavio},
  booktitle = {32th Annual Network and Distributed System Security Symposium, \{NDSS\} 2025, San Diego, California, USA, February 23 - 28, 2025,},
  doi = {XXX},
  month = feb,
  publisher = {The Internet Society},
  title = {{Dumpling: Fine-grained Differential JavaScript Engine Fuzzing}},
  url = {XXX},
  year = {2025}
}
```

### Repository Layout

- [bug_finding_and_overhead](./bug_finding_and_overhead) contains commands to reproduce the bugs found and the overhead experiments (sections V.A and V.C).
- [sensitivity](./sensitivity) contains the commands to reproduce the sensitivity experiments (Section V.B)
- [hyperparameters](./hyperparameters) contains the commands to reproduce the hyperparamter experiment (Section V.D)

## Artifact Evaluation

**Disclaimer:** since many steps run for a few hours, we recommend you operate in a `screen` session to avoid loosing partial results or environment values.
Additionally, Dumpling is still a research prototype with a liberal amount of logging still enabled.
Errors or warnings messages can be printed as part of the build process.

**Machine Requirements:** We recommend to run the experiments on a Intel or AMD machine (ARM is not supported yet) with 16 physical cores, 64 GB of RAM, and at least 100 GB of free space on the hard drive.
We tested our prototype on an Ubuntu 22.04.

### Getting code and initial requirements

```bash
sudo apt install -qq -y python3-pip git curl screen
git clone https://github.com/two-heart/dumpling-artifact-evaluation.git
cd dumpling-artifact-evaluation.git
```

---

### Requirements

Install dependencies.

```bash
cd dumpling-artifact-evaluation

# Install Docker in case it is missing
if docker compose ; then
  echo "docker compose already installed"
else 
  curl -sSL https://get.docker.com/ | sudo sh
  sudo groupadd docker || true
  sudo usermod -aG docker $USER
  sudo systemctl start docker
  newgrp docker
  docker run hello-world
fi
```

### Evaluation

The evaluation reproduces the results in sections V.A, V.B, V.C, and V.D.

## Bug Finding (V.A)

Folder `./poc` contains the JS inputs detected during our fuzzing campaigns and listed in Table I. 

## Bug Oracle Sensitivity (V.B)

This command reproduces the sensitivity experiment depicted in Figure 7.
Specifically, we run Dumpling for the first 10,000 inputs and dump a hash
representation of the states observed.

```bash
cd dumpling-artifact-evaluation
docker compose up -d dumpling-eval-sensitivity
ls ./sensitivity/data
```

The folder `./sensitivity/data` contains the results, the file
`execHashes10000.csv` contains the dump values and `./data/sensitivity.pdf` the
visual representation.

## Running Oracle Overhead (V.C)

This command reproduces the coverage.
For the paper, we run a 10-fold experiment of 72 hours each.

The fuzzing campaign is controlled by three parameters defined 
in `docker-compose.yml`:

- `EXP_RUN_HOURS`: number of hours for a single run (72 in the paper)
- `EXP_NUM_RUNS`: number of runs (10 in the paper)
- `NUM_JOBS`: number of logical cores allocated (30 in the paper)

To demonstrate our points, we scale down to 

```bash
cd dumpling-artifact-evaluation
docker compose up -d dumpling-eval-bug-finding-and-overhead
ls ./bug_finding_and_overhead/data/
```

This will produce a `coverage.pdf`, stats, and the differentials found in `./bug_finding_and_overhead/data`.

## Hyperparameters (V.D)

This command reproduces the hyperparameter results showed in Table II.
Specifically, we run Dumpling for the first 10,000 inputs with different configurations, measure execution per second and dump size.

```bash
cd dumpling-artifact-evaluation
docker compose up -d dumpling-eval-hyperparameters
ls ./hyperparameters/data
```

The file `./data/hyperparam_eval.tex` contains the results as shown in Table II.
