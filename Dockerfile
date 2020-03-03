FROM ubuntu:16.04

# NOTE: LRSIM will not compile in Ubuntu 18.04.

# Install packages necessary to compile LRSIM and run the test script.
RUN apt-get update -yqq --fix-missing && \
    apt-get upgrade -yqq && \
    apt-get install -yqq \
                    perl \
                    libmath-random-perl \
                    libinline-perl \
                    make \
                    gcc \
                    g++ \
                    libncurses5-dev \
                    zlib1g-dev \
                    musl-dev

# Add LRSIM source from release v1.0 to path.
# LRSIM 1.0 is available here:
# https://github.com/aquaskyline/LRSIM/releases/tag/1.0
ADD LRSIM-1.0.tar.gz /

RUN mv LRSIM-1.0 LRSIM

# Compile LRSIM.
WORKDIR /LRSIM
RUN sh make.sh

# Run the test script.
WORKDIR test
RUN sh test.sh

# Remove files produced by test.sh.
# I do this for two reasons:
# These files are large.
# test.sh will skip a lot of steps if these files are already present.
RUN rm -r _Inline/ \
    test1.0.fp \
    test1.0.manifest \
    test1.0.sort.manifest \
    test1.1.fp \
    test1.1.manifest \
    test1.1.sort.manifest \
    test1.dwgsim.0.12.fastq \
    test1.dwgsim.1.12.fastq \
    test1.hap.0.clean.fasta \
    test1.hap.0.clean.fasta.fai \
    test1.hap.0.fasta \
    test1.hap.1.clean.fasta \
    test1.hap.1.clean.fasta.fai \
    test1.hap.1.fasta \
    test1.hap.hetA.bed \
    test1.hap.hetA.insertions.fa \
    test1.hap.hetB.bed \
    test1.hap.hetB.insertions.fa \
    test1.hap.homAB.bed \
    test1.hap.homAB.insertions.fa \
    test1.hap.parameter \
    test1.hapA.fasta \
    test1.hapB.fasta \
    test1.status \
    test1_S1_L001_R1_001.fastq.gz \
    test1_S1_L001_R2_001.fastq.gz \
    test1_S1_L002_R1_001.fastq.gz \
    test1_S1_L002_R2_001.fastq.gz

# Compress the compiled LRSIM directory so it is easy to copy out of a container.
WORKDIR /
RUN tar czf LRSIM-1.0-compiled.tar.gz LRSIM

