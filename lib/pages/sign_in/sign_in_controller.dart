import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_project/pages/sign_in/widgets/flutter_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/sign_in_blocs.dart';

class SignInController{
  final BuildContext context;
  const SignInController({required this.context});

  Future<void> handleSignIn(String type) async {
       try{
         if(type == "email"){
           //BlocProvider,of<SignInBloc>(context).state
           final state = context.read<SignInBloc>().state;
           String emailAddress = state.email;
           String password = state.password;
           if(emailAddress.isEmpty){
             toastInfo(msg: "Bạn cần điền địa chỉ email của bạn");
             return;

           }else{
             print("email is $emailAddress");
           }
           if(password.isEmpty){
             toastInfo(msg: "Bạn cần điền mật khẩu của bạn");
             return;


           }

           try {
             final credential = await FirebaseAuth.instance
                 .signInWithEmailAndPassword(
                 email: emailAddress, password: password);
             if (credential.user == null) {
               toastInfo(msg: "Tài khoản không tồn tại");
               return;

             }
             if (credential.user!.emailVerified) {
               toastInfo(msg: "Bạn cần xác thực tài khoản email của bạn");
               return;

             }else{
               print("no user");
             }
             var user = credential.user;
             if(user!=null){
               print("user exist");
               //we got verified user from firebase
             }else{
               toastInfo(msg: "Bạn chưa có tài khoản trong ứng dụng");
               return;
               //we have error getting user from firebase
             }
           } on FirebaseAuthException catch(e){
             if(e.code == 'user-not-found'){
               print ('No user found for that email');
               toastInfo(msg: "No user found for that email.");
               return;
             }else if(e.code =='wrong-password'){
               print('Wrong password provider for that user.');
               toastInfo(msg:"Wrong password provided for that user.");
               return;
             } else if(e.code=='invalid-email'){
               print("Your email format is wrong");
               toastInfo(msg: "Bạn đã nhập không đúng định dạng email");
               return;

         }
           }


         }
       } catch(e){
         print(e.toString());
       }
  }
}