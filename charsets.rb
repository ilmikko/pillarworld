require("./console.rb");
require("./screen.rb");

require 'io/console';

charsets=[
        {
                t:"ASCII",
                a:[33,126]
        },
        {
                t:"Basic charset",
                a:[48,57,65,90,97,122]
        },
        {
                t:"Extended charset",
                a:[192,382]
        },
        {
                t:"RAW 1",
                a:[900,1129]
        },
        {
                t:"Plants",
                a:[34,34,39,39,44,44,46,46,909,909,910,910,912,912,943,943,947,947,964,964,978,980]
        },
        {
                t:"Pointy",
                a:[990,991]
        },
        {
                t:"Furniture",
                a:[1060,1060,1092,1092]
        },
        {
                t:"Manmade",
                a:[1002,1003,1006,1007]
        },
        {
                t:"RAW 2",
                a:[5100,5200]
        },
        {
                t:"RAW 3",
                a:[5200,5555]
        },
        {
                t:"RAW 4",
                a:[5751,5880]
        },
        {
                t:"RAW 5",
                a:[8200,8300]
        },
        {
                t:"RAW 6",
                a:[8300,8330]
        },
        {
                t:"RAW 7",
                a:[8590,8710]
        },
        {
                t:"RAW 8",
                a:[8700,8860]
        },
        {
                t:"RAW 9",
                a:[8850,8988]
        },
        {
                t:"RAW 10",
                a:[9020,9080]
        },
        {
                t:"RAW 11",
                a:[9115,9169]
        },
        {
                t:"RAW 12",
                a:[9470,9630]
        },
        {
                t:"RAW 13",
                a:[9550,9740]
        },
        {
                t:"RAW 14",
                a:[9800,9935]
        },
        {
                t:"RAW 15",
                a:[9980,10060]
        },
        {
                t:"RAW 16",
                a:[10080,10101]
        },
        {
                t:"RAW 17",
                a:[10230,10500]
        },
        {
                t:"RAW 18",
                a:[10530,10630]
        },
        {
                t:"RAW 19",
                a:[11000,11123]
        },
        {
                t:"RAW 20",
                a:[19870,20029]
        },
        {
                t:"RAW 21",
                a:[119500,119659]
        },
        {
                t:"RAW 22",
                a:[119800,120931]
        }
        ];

$screen.clear();

charsets.each do |cs|

        $screen.write("\x1b[36m");
        $screen.write("%-22.22s: "%cs[:t]);
        $screen.write("\x1b[0m");

        csa=cs[:a];

        $screen.write("\x1b[100m");

        a=0;
        b=1;

        while csa[b]
                for i in csa[a]..csa[b]
                        $screen.write(i.chr("utf-8"));
                end

                a+=2;
                b+=2;
        end

        $screen.write("\x1b[0m");
        $screen.write("\r\n");
end

# Pause until keypress
STDIN.getch;

$screen.close();
