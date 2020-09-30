#!/data/data/com.termux/files/usr/bin/bash


# just return info
function getinfo {
    echo ""
    echo "INFO:"
    echo ""

    su -c "sysctl kernel.sched_tunable_scaling"
    su -c "sysctl kernel.sched_latency_ns"
    su -c "sysctl kernel.sched_min_granularity_ns"
    su -c "sysctl kernel.sched_wakeup_granularity_ns"
    su -c "sysctl kernel.sched_migration_cost_ns"
    echo ""

    echo -n "schedtune.boost:    "
    su -c "cat /dev/stune/schedtune.boost"
    echo -n "foreground boost:   "
    su -c "cat /dev/stune/foreground/schedtune.boost"
    echo -n "top-app boost:      "
    su -c "cat /dev/stune/top-app/schedtune.boost"
    echo ""

    echo "cpufreq up rate limits:"
    su -c "cat /sys/devices/system/cpu/cpufreq/policy0/schedutil/up_rate_limit_us"
    su -c "cat /sys/devices/system/cpu/cpufreq/policy6/schedutil/up_rate_limit_us"
    echo ""

    echo "cpufreq down rate limits:"
    su -c "cat /sys/devices/system/cpu/cpufreq/policy0/schedutil/down_rate_limit_us"
    su -c "cat /sys/devices/system/cpu/cpufreq/policy6/schedutil/down_rate_limit_us"
    echo ""

    termux-toast "got info"
}


# regular tuning
function regtune {
    echo "regular tuning"
    sysctl su -c "-w kernel.sched_tunable_scaling=1"
    su -c "sysctl -w kernel.sched_latency_ns=600000"
    su -c "sysctl -w kernel.sched_min_granularity_ns=400000"
    # sysctl -w kernel.sched_wakeup_granularity_ns=500000
    su -c "sysctl -w kernel.sched_migration_cost_ns=250000"

    su -c "echo 20 > /dev/stune/schedtune.boost"
    su -c "echo 15 > /dev/stune/foreground/schedtune.boost"
    su -c "echo 20 > /dev/stune/top-app/schedtune.boost"

    # echo 0 > /sys/devices/system/cpu/cpufreq/policy0/schedutil/up_rate_limit_us
    # echo 0 > /sys/devices/system/cpu/cpufreq/policy6/schedutil/up_rate_limit_us

    termux-toast "regular tune done"
}

# aggressive tuning
function aggressive {
    echo "aggresive tuning"
    su -c "sysctl -w kernel.sched_tunable_scaling=1"
    su -c "sysctl -w kernel.sched_latency_ns=600000"
    su -c "sysctl -w kernel.sched_min_granularity_ns=400000"
    su -c "sysctl -w kernel.sched_wakeup_granularity_ns=500000"
    su -c "sysctl -w kernel.sched_migration_cost_ns=250000"

    su -c "echo 20 > /dev/stune/schedtune.boost"
    su -c "echo 15 > /dev/stune/foreground/schedtune.boost"
    su -c "echo 20 > /dev/stune/top-app/schedtune.boost"

    su -c "echo 0 > /sys/devices/system/cpu/cpufreq/policy0/schedutil/up_rate_limit_us"
    su -c "echo 0 > /sys/devices/system/cpu/cpufreq/policy6/schedutil/up_rate_limit_us"

    termux-toast "aggressive tune done"
}


# untune / revert
function untune {
    echo "un-tuning"
    su -c "sysctl -w kernel.sched_tunable_scaling=0"
    su -c "sysctl -w kernel.sched_latency_ns=10000000"
    su -c "sysctl -w kernel.sched_min_granularity_ns=3000000"
    su -c "sysctl -w kernel.sched_wakeup_granularity_ns=2000000"
    su -c "sysctl -w kernel.sched_migration_cost_ns=500000"

    su -c "echo 0  > /dev/stune/schedtune.boost"
    su -c "echo 0  > /dev/stune/foreground/schedtune.boost"
    su -c "echo 10 > /dev/stune/top-app/schedtune.boost"

    su -c "echo 500 > /sys/devices/system/cpu/cpufreq/policy0/schedutil/up_rate_limit_us"
    su -c "echo 500 > /sys/devices/system/cpu/cpufreq/policy6/schedutil/up_rate_limit_us"

    termux-toast "untune done"
}


export response=`termux-dialog radio -t "choose option" -v "info,regular,aggressive,untune" | grep 'text": ' | perl -pe 's/.+ "(\w+)".*/$1/'`;

if [[ "$response" == "info" ]]; then
    getinfo;
elif [[ "$response" == "regular" ]]; then
    regtune;
elif [[ "$response" == "aggressive" ]]; then
    aggressive;
elif [[ "$response" == "untune" ]]; then
    untune;
else
    echo "??";
fi

