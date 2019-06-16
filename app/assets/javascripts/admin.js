//= require jquery
//= require jquery_ujs
//= require_tree .

$(document).ready(function() {
    const searchParams = new URLSearchParams(window.location.search);
    const token = searchParams.get('token');

    $('button#btn-create').click(function() {
        window.location.href = `/admin?token=${token}`;
    });

    $('button#btn-edit').click(function() {
        const id = $('#edit-id').val();
        window.location.href = `/admin?token=${token}&id=${id}`;
    });

    $('#news_title').change(function() {
        $('#preview-news-title').html($(this).val());
    });

    $('#news_content').on('input', function(e) {
        $('#preview-news-content').html(marked($(this).val()));
    });

    $('#channel').change(function() {
        const channel = $('#channel option:selected').text();
        const event = $('#event option:selected').text();
        $('#preview-news-channel').html(`${channel} | ${event}`);
    });

    $('#event').change(function() {
        const channel = $('#channel option:selected').text();
        const event = $('#event option:selected').text();
        $('#preview-news-channel').html(`${channel} | ${event}`);
    });

    $('button#btn-translate').click(function() {
        const word = $('#word').val();
        $.getJSON('/translate', {
            entry: word,
            token: token,
        }, function(data) {
            console.log(data);
            if (!data || !data.translations) {
                return;
            }
            result = data.translations[0];
            $('#translation-result').text(result);
        });
    });
});
