$(document).ready(function () {

    // Hide field 'acquire_query' when parent is no collection

    var jq_acquire_query, ajax_url, response;

    jq_acquire_query = $('#formfield-form-widgets-ICollection-acquire_query');
    if (jq_acquire_query.length && (document.URL.search('/edit') !== -1)) {
        ajax_url = document.URL.split('/edit')[0];
        ajax_url = ajax_url + '/@@is_subcollection';
        response = $.ajax({'url': ajax_url});
        if (response.responseText !== "True") {
            jq_acquire_query.hide();
        }
    }
});