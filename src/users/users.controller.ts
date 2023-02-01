import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  UseGuards
} from '@nestjs/common';
import { AuthGuard } from '../auth.guard';
import { UsersService } from './users.service';
import { CreateUserDto } from './dto/create-user.dto';
import { UpdateUserDto } from './dto/update-user.dto';

import { User as UserModel } from '@prisma/client';

@Controller('users')
export class UsersController {
  constructor(private readonly usersService: UsersService) {}

  // CREAR USUARIO
  @Post()
  @UseGuards(AuthGuard)
  create(@Body() createUserDto: CreateUserDto) {
    return this.usersService.create(createUserDto);
  }

  // OBTENER TODOS LOS USUARIOS
  @Get()
  @UseGuards(AuthGuard)
  async findAll(): Promise<UserModel[]> {
    return this.usersService.findAll({});
  }

  // OBTENER USUARIO POR EMAIL
  @Get(':email')
  findOne(@Param('email') email: string): Promise<UserModel> {
    return this.usersService.findOne({ email: email });
  }

  // EDITAR USUARIO POR EMAIL
  @Patch(':email')
  @UseGuards(AuthGuard)
  update(@Param('email') email: string, @Body() updateUserDto: UpdateUserDto) {
    return this.usersService.update(email, updateUserDto);
  }

  // ELIMINAR USUARIO POR EMAIL
  @Delete(':email')
  @UseGuards(AuthGuard)
  remove(@Param('email') email: string): Promise<UserModel> {
    return this.usersService.remove({ email: email });
  }
}
