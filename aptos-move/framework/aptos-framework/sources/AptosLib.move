module AptosFramework::AptosLib {
    native fun type_of<T>(): (address, vector<u8>, vector<u8>);

    #[test]
    fun test() {
        let (addr, module_name, struct_name) = type_of<AptosFramework::Account::Account>();
        assert!(addr == @AptosFramework, 0);
        assert!(module_name == b"Account", 1);
        assert!(struct_name == b"Account", 2);
    }
}
