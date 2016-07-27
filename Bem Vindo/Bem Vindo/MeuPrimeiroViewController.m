//
//  MeuPrimeiroViewController.m
//  Bem Vindo
//
//  Created by Antonio Lopes on 7/25/16.
//  Copyright © 2016 Antonio Lopes. All rights reserved.
//

#import "MeuPrimeiroViewController.h"

@implementation MeuPrimeiroViewController

#pragma mark - View lifecycle
-(void)viewDidLoad {
    [super viewDidLoad];
    meuPrimeiroLabel.text = @"Tela iniciada com sucesso!";
    
    // Indica que a própria classe implementa o protocolo UITextFieldDelegate para responder aos eventos
//    meuPrimeiroTextField.delegate = self;
//    meuSegundoTextField.delegate = self;
    
    // Altera a imagem dinamicamente
    UIImage *image = [UIImage imageNamed:@"ferrari_ff.png"];
    imageView.image = image;
}

-(IBAction)olaMundo:(id)sender {
    NSLog(@"Olá");

    if ([meuSegundoTextField.text isEqualToString:@""] || [meuSegundoTextField.text isEqualToString:@""]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Erro" message:@"Digite todos os campos" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction *action)
                                   {
                                       NSLog(@"OK action");
                                   }];
        [alertController addAction:okAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
    NSString *s = @"Olá ";
    
    // Nome
    s = [s stringByAppendingString:meuSegundoTextField.text];
    
    // Espaço
    s = [s stringByAppendingString:@" "];
    
    // Sobrenome
    s = [s stringByAppendingString:meuSegundoTextField.text];

    meuPrimeiroLabel.text = s;
    
    // Libera o foco para fechar o teclado virtual
    [meuPrimeiroTextField resignFirstResponder];
    [meuSegundoTextField resignFirstResponder];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // Libera o foco para fechar o teclado virtual
    [meuPrimeiroTextField resignFirstResponder];
    [meuSegundoTextField resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == meuPrimeiroTextField) {
        // Navega par ao próximo campo
        [meuSegundoTextField becomeFirstResponder];
        return YES;
    } else if (textField == meuSegundoTextField) {
        // Último campo xecuta o método olaMundo diretamente
        [self olaMundo:textField];
        return YES;
    }
    return NO;
}

-(IBAction)sliderValueChanged:(id)sender {
    UISlider *slider = sender;
    imageView.alpha = [slider value];
}
@end
