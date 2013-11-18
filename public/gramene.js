function ucfirst(string) {
    if (string != undefined && string.length) {
        return string.charAt(0).toUpperCase() + string.slice(1);
    }
};

function scrubAndAppend($elem) {
    var bucket = stripIDs($elem);

    var scripts = $('script');
    var current = scripts[scripts.length - 1];

    $(current).after($elem);

    return bucket;

};

function stripIDs($elem, bucket) {

    if (bucket == undefined) {
        bucket = {};
    }

    if ($elem.attr('id')) {
        bucket[$elem.attr('id')] = $elem;
        $elem.attr('data-rewired-id', $elem.attr('id'));
        $elem.removeAttr('id');
    }

    $.each(
        $elem.find('[id]'),
        function(idx) {
            bucket[$(this).attr('id')] = $(this);
            $(this).attr('data-rewired-id', $(this).attr('id'));
            $(this).removeAttr('id');
        }
    );

    return bucket;
};

function truncate_field(field, length) {

    if (field == undefined || field.length == 0) {
        return '';
    }

    var visible = field.slice(0,length);
    var extra   = field.slice(length);

    label = $.jqElem('span').html(visible);

    if (extra.length) {
        label
        .append(
            $.jqElem('a')
                .append('...(more)')
                .on('click',
                    function(e) {
                        console.log(e.target);
                        var $target = $(e.target);
                        var $container = $target.parent();
                        $(e.target).remove();
                        $container.append(
                            $.jqElem('span').html(extra)
                        );
                    }
                )
        );
    }

    return label;
}

function truncate_list(list, length) {

    if (list == undefined || list.length == 0) {
        return '';
    }


    var authors = list.split(',');
    if (authors.length > length) {
        var visible = authors.splice(0,length);
    }
    else {
        visible = authors;
        authors = [];
    }

    label = $.jqElem('span').html(visible.join('<br>'));

    if (authors.length) {
        label.append($.jqElem('br'))
        .append(
            $.jqElem('a')
                .append('et. al.')
                .on('click',
                    function(e) {
                        console.log(e.target);
                        var $target = $(e.target);
                        var $container = $target.parent();
                        $(e.target).remove();
                        $container.append(
                            $.jqElem('span').html(authors.join('<br>'))
                        );
                    }
                )
        );
    }

    return label;
}

$(function() {

    $('[data-ajax-url]').each(
        function (idx, elem) {

            if ($(elem).attr('data-ajax-spinnersize') == undefined) {
                $(elem).attr('data-ajax-spinnersize', 'icon-4x');
            }

            var spinnerClass = 'icon-spinner icon-spin ' + $(elem).attr('data-ajax-spinnersize');

            $(elem).empty();
            $(elem).append(
                $('<div></div>')
                    .css('text-align', 'center')
                    .append(
                        $('<i></i>')
                            .addClass(spinnerClass)
                    )
            );

            $.get($(elem).attr('data-ajax-url'))
                .done(function(html) {$(elem).empty(); $(elem).html(html)})
                .error(
                    function(jqXHR) {
                        $(elem).empty();
                        $(elem).html(
                            $('<div></div>')
                                .addClass('alert alert-danger')
                                .append("Error loading: <i>" + $(elem).attr('data-ajax-url') + '</i><br>')
                                .append("<b>" + jqXHR.status + ' : ' + jqXHR.statusText + "</b>")
                        )
                    }
                );
        }
    );

});
