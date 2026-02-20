mod extension;

#[no_mangle]
pub extern "C" fn launch() {
    extension::run();
}
