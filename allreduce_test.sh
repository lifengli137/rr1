nhost=$(($# * 8))
hosts=""
for arg in "$@"
do
    hosts="$hosts$arg:8,"
done

echo "Number of processes: $nhost"
echo "Host list: $hosts"


mpirun --allow-run-as-root -np $nhost -host $hosts -mca pml ucx --mca btl ^vader,tcp,openib -x NCCL_IB_HCA=mlx5_0,mlx5_1,mlx5_2 -x NCCL_DEBUG=WARN /opt/nccl-tests-2.11.0/build/all_reduce_perf -b 2G -e 2G -c 1 -w 20 -n 5; 
