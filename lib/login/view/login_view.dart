import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_cubit_example/login/viewmodel/login_cubit.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);

  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(
        formKey,
        passwordController,
        emailController,
      ),
      child: buildScaffold(context),
    );
  }

  Scaffold buildScaffold(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Cubit Login",
        ),
      ),
      body: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.disabled,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildTextFormFieldMail(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            buildTextFormFieldPassword(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text("Save"),
            )
          ],
        ),
      ),
    );
  }

  TextFormField buildTextFormFieldPassword() {
    return TextFormField(
      controller: passwordController,
      // controller: context.read<LoginCubit>().passwordController,
      validator: (val) =>
          (val ?? "").length > 5 ? null : "can not be lower than 5",
      decoration: const InputDecoration(
        labelText: "Password",
        border: OutlineInputBorder(),
      ),
    );
  }

  TextFormField buildTextFormFieldMail() {
    return TextFormField(
      controller: emailController,
      //  controller: context.read<LoginCubit>().emailController,
      validator: (val) =>
          (val ?? "").length > 5 ? null : "can not be lower than 6",
      decoration: const InputDecoration(
        labelText: "E-mail",
        border: OutlineInputBorder(),
      ),
    );
  }
}
