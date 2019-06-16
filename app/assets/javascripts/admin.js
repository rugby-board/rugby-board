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
            if (!data || !data.translations) {
                return;
            }
            result = data.translations[0];
            $('#translation-result').text(result);
        });
    });

    $('button#btn-table').click(function() {
        $('#toolbox-content').text(`| 主队 | 比分 | 客队 |
|----|----|----|
|  |  |  |
|  |  |  |
|  |  |  |`);
    });

    $('button#btn-format').click(function() {
        const input = $('#format-content').val();
        const lines = input.split('\n');
        const teams = [];
        let formatted = '| 主队 | 比分 | 客队 |\n|----|----|----|\n';
        for (let i = 0; i < lines.length; i += 1) {
            const line = lines[i];
            const results = line.split('\t');
            for (let j = 0; j < results.length; j += 1) {
                if (j === 0) {
                    continue;
                }
                if (j === 1) {
                    formatted += '| ';
                }
                if (j === 1 || j === 3) {
                  teams.push(results[j]);
                }
                formatted += results[j] + ' | ';
            }
            formatted += '\n';
        }
        const queryTeams = teams.join(' | ');
        let pos = 0;
        $.getJSON('/translate', {
            entry: queryTeams,
            token: token,
        }, function(data) {
            const translations = data.translations;
            for (let i = 0; i < translations.length; i += 1) {
                const chineseWord = translations[i];
                const englishWord = teams[i];
                pos = formatted.indexOf(englishWord, pos);
                formatted = [formatted.slice(0, pos), chineseWord + ' ', formatted.slice(pos)].join('');
            }
            $('#format-content').val(formatted);
        });
    })
});
