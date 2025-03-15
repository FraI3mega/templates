{
  outputs = { self }: {
    templates = {
     rusttemplate = {
        path = ./rust;
        description = "Rust dev template";
      };
    };
  };
}
