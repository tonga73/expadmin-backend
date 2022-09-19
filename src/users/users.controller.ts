import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
} from '@nestjs/common';
import { UsersService } from './users.service';
import { CreateUserDto } from './dto/create-user.dto';
import { UpdateUserDto } from './dto/update-user.dto';

import { User as UserModel } from '@prisma/client';

@Controller('users')
export class UsersController {
  constructor(private readonly usersService: UsersService) {}

  // CREAR USUARIO
  @Post()
  create(@Body() createUserDto: CreateUserDto) {
    return this.usersService.create(createUserDto);
  }

  // OBTENER TODOS LOS USUARIOS
  @Get()
  async findAll(): Promise<UserModel[]> {
    return this.usersService.findAll({});
  }

  // OBTENER USUARIO POR ID
  @Get(':id')
  findOne(@Param('id') id: string): Promise<UserModel> {
    return this.usersService.findOne({ id: Number(id) });
  }

  // EDITAR USUARIO POR ID
  @Patch(':id')
  update(@Param('id') id: string, @Body() updateUserDto: UpdateUserDto) {
    return this.usersService.update(+id, updateUserDto);
  }

  // ELIMINAR USUARIO POR ID
  @Delete(':id')
  remove(@Param('id') id: string): Promise<UserModel> {
    return this.usersService.remove({ id: Number(id) });
  }
}
