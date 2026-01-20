import "jquery";
import "bootstrap";
import Rails from "@rails/ujs";
Rails.start();
import "@hotwired/turbo-rails";
import "controllers";


document.addEventListener('DOMContentLoaded', () => {
    document.querySelectorAll('.toast').forEach((toast) => {
        toast.style.display = 'block';
        setTimeout(() => {
            toast.style.display = 'none';
        }, 4000);
    });
});

