import {
  Controller,
  Get,
  Param,
  Post,
  Body,
  Put,
  Delete,
  UseGuards,
} from '@nestjs/common';
import { AuthGuard } from './auth.guard';
import { AppService } from './app.service';

import { Role, Tracing, Priority } from '@prisma/client';

@Controller()
export class AppController {
  constructor(private readonly appService: AppService) {}

  @Get()
  getHello(): string {
    return this.appService.getHello();
  }

  @Get('roles')
  @UseGuards(AuthGuard)
  getRoles(): object {
    return Role;
  }

  @Get('tracings')
  @UseGuards(AuthGuard)
  getTracings(): object {
    return Tracing;
  }

  @Get('priorities')
  @UseGuards(AuthGuard)
  getPriorities(): object {
    return Priority;
  }
}
