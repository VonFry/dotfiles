case "$(unname)" in
    "Darwin")
        source $script_dir/setup/macos.sh
        ;;
    "Linux")
        source /etc/os-release
        sudo ln -f -s $script_dir/etc/issue /etc/issue
        case "$(ID)" in
            "gentoo")
                source $script_dir/setup/gentoo.sh
                ;;
            "*")
                echo_warn " ! The linux release is not supported."
                exit 1
                ;;
        esac
        ;;
    "*")
        echo_warn " ! The os is not supported."
        exit 1
        ;;
esac
