/**
 * 
 */

document.addEventListener("DOMContentLoaded", function () {

    const form = document.querySelector("form");
    const username = document.querySelector('input[name="username"]');
    const password = document.querySelector('input[name="password"]');

    // Username validation
    username.addEventListener("input", function () {

        if (username.value.trim() === "") {
            username.style.borderColor = "#dc3545";
        } else {
            username.style.borderColor = "#20b486";
        }

    });

    // Password validation
    password.addEventListener("input", function () {

        if (password.value.length < 6) {
            password.style.borderColor = "#dc3545";
        } else {
            password.style.borderColor = "#20b486";
        }

    });

    // Form validation
    form.addEventListener("submit", function (event) {

        const usernameValue = username.value.trim();
        const passwordValue = password.value.trim();

        if (usernameValue === "") {

            event.preventDefault();

            alert("Please enter your username or email.");

            username.focus();

            return;
        }

        if (passwordValue === "") {

            event.preventDefault();

            alert("Please enter your password.");

            password.focus();

            return;
        }

        if (passwordValue.length < 6) {

            event.preventDefault();

            alert("Password must contain at least 6 characters.");

            password.focus();

            return;
        }

    });

});