function jekyll-new-post()
{
    echo -n "slug: "
    read slug
    postfile=$(date +%F)-$slug.md
    touch $postfile

    echo "---" > $postfile

    echo -n "title: "
    read title
    echo "title: $title" >> $postfile

    echo "date: $(date "+%Y-%m-%d %H:%M:%S %z")" >> $postfile

    echo -n "categories: "
    read categories
    echo "categories: $categories" >> $postfile

    echo -n "tags: "
    read tags
    echo "tags: $tags" >> $postfile

    echo -n "image: "
    read image
    if [ -v "image" -a ! -z $image ]; then
        echo "image: $image" >> $postfile
    fi

    echo -n "description: "
    read description
    if [ -v "description" -a ! -z $description ]; then
        echo "description: $description" >> $postfile
    fi
    echo -n "twitter_text: "
    read twitter_text
    if [ -v "twitter_text" -a ! -z $twitter_text ]; then
        echo "twitter_text: $twitter_text" >> $postfile
    fi

    echo "---" >> $postfile

    case "$(uname)" in
        "Darwin")
            open $postfile
        ;;
        "Linux")
            editor $postfile
        ;;
    esac
}