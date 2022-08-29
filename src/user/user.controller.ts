import { Body, Controller, Get, Post } from '@nestjs/common';
import { UserService } from './user.service';
import { User as UserModel } from '@prisma/client';

@Controller()
export class UserController {
  constructor(private readonly userService: UserService) {}

  // OBTENER TODOS LOS USUARIOS
  @Get('users')
  async getUsers(): Promise<UserModel[]> {
    return this.userService.users({});
  }

  // OBTENER USUARIO
  @Post('user/login')
  async loginUser(@Body() userData: { email: string }): Promise<UserModel> {
    return this.userService.user(userData);
  }

  // CREAR USUARIO
  @Post('user')
  async signupUser(
    @Body() userData: { name?: string; email: string },
  ): Promise<UserModel> {
    return this.userService.createUser(userData);
  }
}
