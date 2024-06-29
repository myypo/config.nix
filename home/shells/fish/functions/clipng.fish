function clipng
    if set -q argv
        wl-paste -t image/png >"$argv.png"
    else
        wl-paste -t image/png >"$(date +%Y-%m-%d_%T).png"
    end
end
