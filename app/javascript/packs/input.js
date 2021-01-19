import $ from 'jquery';

$(() => {
    var $browse_btn = $("#browse_button");
    var $csvfile_input = $("#csvfile");
    var $identifier_input = $("#identifier");
    var $filename_disp = $("#filename_display");
    var $submit_btn = $("#submit_button");

    function setAndReportValidity(domObj, message) {
        domObj.setCustomValidity(message);
        return domObj.reportValidity();
    }

    function csvfile() {
        return $csvfile_input[0].files[0];
    }

    function validate_identifier() {
        var identifier = $identifier_input.val();
        var valid_regex = /^[0-9a-z]+$/i;
        var validity = ''

        if (document.skip_identifier_validate) {
            return true;
        }
        if (!identifier) {
            validity = 'Please enter an identifier';
        } else if (identifier.length == 1) {
            validity = 'Identifier length must be > 1';
        } else if (!identifier.match(valid_regex)) {
            validity = 'Only alphanumeric characters are permitted';
        }
        return setAndReportValidity($identifier_input[0], validity);
    }

    function validate_csvfile() {
        var validity = !csvfile() ? 'Please select a file for upload' : '';

        return setAndReportValidity($browse_btn[0], validity);
    }

    $submit_btn.on('click', (event) => {
        var validations = [ validate_identifier, validate_csvfile ]
    
        for (var i in validations)
            if (validations[i]() == false)
                return false;   /* bail at first error */
        return true;
    });

    $browse_btn.on('click', (event) => {
        $csvfile_input.click()
        event.preventDefault();
    })

    $csvfile_input.on('change', (event) => {
        var f = csvfile();

        $filename_disp.text(f ? '(' + f.name + ')' : '');
    })
})
