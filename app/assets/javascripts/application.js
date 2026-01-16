
document.addEventListener('DOMContentLoaded', () => {
    document.querySelectorAll('.toast').forEach((toast) => {
        toast.style.display = 'block';
        setTimeout(() => {
            toast.style.display = 'none';
        }, 4000); // Hide after 4 seconds
    });
});
