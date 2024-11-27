#!/bin/bash
resources=(
  "aws_vpc.dev-victor"
  "aws_subnet.dev-victor"
)

for resource in "${resources[@]}"; do
  targets+=" -target=$resource"
done

terraform apply $targets
