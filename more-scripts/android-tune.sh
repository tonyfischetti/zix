#!/data/data/com.termux/files/usr/bin/sh

if [ $# -eq 0 ] ; then
    echo "tuning"
    sysctl -w kernel.sched_tunable_scaling=1
    sysctl -w kernel.sched_latency_ns=600000
    sysctl -w kernel.sched_min_granularity_ns=400000
    # sysctl -w kernel.sched_wakeup_granularity_ns=500000
    sysctl -w kernel.sched_migration_cost_ns=250000

    echo 20 > /dev/stune/schedtune.boost
    echo 15 > /dev/stune/foreground/schedtune.boost
    echo 20 > /dev/stune/top-app/schedtune.boost

    # echo 0 > /sys/devices/system/cpu/cpufreq/policy0/schedutil/up_rate_limit_us
    # echo 0 > /sys/devices/system/cpu/cpufreq/policy6/schedutil/up_rate_limit_us
elif [ $1 = "-a" ] ; then
    echo "aggresive tuning"
    sysctl -w kernel.sched_tunable_scaling=1
    sysctl -w kernel.sched_latency_ns=600000
    sysctl -w kernel.sched_min_granularity_ns=400000
    sysctl -w kernel.sched_wakeup_granularity_ns=500000
    sysctl -w kernel.sched_migration_cost_ns=250000

    echo 20 > /dev/stune/schedtune.boost
    echo 15 > /dev/stune/foreground/schedtune.boost
    echo 20 > /dev/stune/top-app/schedtune.boost

    echo 0 > /sys/devices/system/cpu/cpufreq/policy0/schedutil/up_rate_limit_us
    echo 0 > /sys/devices/system/cpu/cpufreq/policy6/schedutil/up_rate_limit_us
elif [ $1 = "-i" ] ; then
    echo "INFO:\n"
    sysctl kernel.sched_tunable_scaling
    sysctl kernel.sched_latency_ns
    sysctl kernel.sched_min_granularity_ns
    sysctl kernel.sched_wakeup_granularity_ns
    sysctl kernel.sched_migration_cost_ns
    echo ""
    echo -n "schedtune.boost:    "
    cat /dev/stune/schedtune.boost
    echo -n "foreground boost:   "
    cat /dev/stune/foreground/schedtune.boost
    echo -n "top-app boost:      "
    cat /dev/stune/top-app/schedtune.boost

    echo "\ncpufreq up rate limits:"
    cat /sys/devices/system/cpu/cpufreq/policy0/schedutil/up_rate_limit_us
    cat /sys/devices/system/cpu/cpufreq/policy6/schedutil/up_rate_limit_us

    echo "\ncpufreq down rate limits:"
    cat /sys/devices/system/cpu/cpufreq/policy0/schedutil/down_rate_limit_us
    cat /sys/devices/system/cpu/cpufreq/policy6/schedutil/down_rate_limit_us
else
    echo "un-tuning"
    sysctl -w kernel.sched_tunable_scaling=0
    sysctl -w kernel.sched_latency_ns=10000000
    sysctl -w kernel.sched_min_granularity_ns=3000000
    sysctl -w kernel.sched_wakeup_granularity_ns=2000000
    sysctl -w kernel.sched_migration_cost_ns=500000

    echo 0  > /dev/stune/schedtune.boost
    echo 0  > /dev/stune/foreground/schedtune.boost
    echo 10 > /dev/stune/top-app/schedtune.boost

    echo 500 > /sys/devices/system/cpu/cpufreq/policy0/schedutil/up_rate_limit_us
    echo 500 > /sys/devices/system/cpu/cpufreq/policy6/schedutil/up_rate_limit_us
fi
